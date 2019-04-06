import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { UserInfoService } from '../../services/user-info.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class AppHeaderComponent implements OnInit {

  constructor(private authService: AuthService, private userInfo: UserInfoService) { }

  ngOnInit() {

  }

  authAdmin() {
    this.authService.login("superadmin@admin.cow", "SuperAdmin");
  }

  authUser() {
    this.authService.login("lion@user.cow", "Lion");
  }

  logout() {
    this.authService.logout();
    return false;
  }

}
