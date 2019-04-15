import { Injectable, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Response } from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import * as jwt_decode from "jwt-decode";
import { Observable } from 'rxjs/Observable';
import { User } from '../models/user';
import { BASE_API_URL } from '../globals';
import { UserRegister } from '../models/user-register';
import { UserPage } from '../models/user-page';
import { UserUpdate } from '../models/user-update';
import { UserInfoService } from './user-info.service';
import { UserNewPassword } from '../models/user-new-password';
import { AdminRegister } from '../models/admin-register';
import { DatePipe } from '@angular/common';
import { UserRoles } from '../models/user-roles';


@Injectable()
export class UserService {

  private basePath: string;
  private basePathS: string;
  private userRegister: UserRegister;

  public UserCache = Object.create(null);

  //private tokenservice: AccessTokenService;

  headers: HttpHeaders = new HttpHeaders({
    "Content-Type": "application/json",
    "Accept": "application/json"
  });
  constructor(private http: HttpClient, private userInfoService: UserInfoService) {

    this.basePath = BASE_API_URL + '/user';
    this.basePathS = this.basePath + '/';
  }

  createUser(user: UserRegister): Observable<any> {
    return this.http.post(this.basePath, user,  { headers: this.headers });
  }

  createAdmin(user: AdminRegister): Observable<any> {
    return this.http.post(this.basePath + '/create-admin', user, { headers: this.headers });
  }

  updateUser(userId: string, user: UserUpdate): Observable<any> {
    return this.http.put(this.basePathS + userId, user, { headers: this.headers });
  }

  addRole(userId: string, role: UserRoles): Observable<any> {
    return this.http.put(this.basePath + "/" + userId + "/add-role", role, { headers: this.headers });
  }

  removeRole(userId: string, role: UserRoles): Observable<any> {
    return this.http.put(this.basePath + "/" + userId + "/remove-role", role, { headers: this.headers });
  }

  deleteUser(userId: string): Observable<any> {
    return this.http.delete(this.basePathS + userId);
  }




  getUserById(userId: string): Observable<User> {
    const path = this.basePathS + userId;
    const obs = this.http.get<User>(path);
    obs.subscribe(result => this.updateUserCache(result));
    return obs;
  }

  getUserByUserName(userName: string): Observable<User> {
    const path = this.basePathS + 'user-name/' + userName;
    const obs = this.http.get<User>(path);
    obs.subscribe(result => this.updateUserCache(result));
    return obs;
  }


  getUserByEmail(userEmail: string): Observable<User> {
    const path = this.basePathS + 'email/' + userEmail;
    const obs = this.http.get<User>(path);
    obs.subscribe(result => this.updateUserCache(result));
    return obs;
  }

  getUsers(): Observable<User[]> {
    const path = this.basePath + 's';
    const obs = this.http.get<User[]>(path);
    obs.subscribe(result => {
      for (let user of result) {
        this.updateUserCache(user);
      }      
    });
    return obs;
  }

  getUsersById(usersId: string[]): Observable<User[]> {
    const obs = this.http.post<User[]>(this.basePathS + 'users-by-id', usersId, { headers: this.headers });
    obs.subscribe(result => {
      for (let user of result) {
        this.updateUserCache(user);
      }
    });
    return obs;
  }






  getUsersPage(page: number, pageSize: number): Observable<UserPage> {
    return this.http.get<UserPage>(this.basePathS + 'page' + '?' + 'PageNumber=' + page + '&' + 'PageSize=' + pageSize);
  }

  getUserRoleById(userId: string): Observable<string[]> {
    return this.http.get<string[]>(this.basePathS + userId + '/roles');
  }

  getBookings(userId: string, startTime?: Date, endTime?: Date): Observable<any> {
    let datePipe = new DatePipe("en-Us");
    let query: String;
    query = "";
    if (!(startTime == undefined || startTime == null)) query = "?startTime=" + datePipe.transform(startTime, 'short');
    if (!(endTime == undefined || endTime == null)) {
      if (query == null) query = "?";
      else query += "&"
      query += "endTime=" + datePipe.transform(endTime, 'short');
    }
    return this.http.get(this.basePathS + userId + '/bookings' + query, { headers: this.headers });
  }

  blockUser(userId: string, blocking: boolean): Observable<Object> {
    return this.http.put(this.basePathS + userId + '/blocking', blocking, { headers: this.headers});
  }

  approvalUser(userId: string, approval: boolean): Observable<Object> {
    return this.http.put(this.basePathS + userId + '/approval', approval, { headers: this.headers });
  }

  restorePassword(userId: string, userPass: UserNewPassword): Observable<Object> {
    return this.http.put(this.basePathS + userId + '/restore-password', userPass, { headers: this.headers });
  }

  changePassword(userId: string, userPass: UserNewPassword): Observable<Object> {
    return this.http.put(this.basePathS + userId + '/change-password', userPass, { headers: this.headers });
  }



  updateUserCache(user: User) {
    this.UserCache[user.id] = user;
  }


}
