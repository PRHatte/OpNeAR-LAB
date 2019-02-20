import { Component, OnInit } from '@angular/core';
import {IssueService} from '../issue.service'; 



@Component({
  selector: 'app-node-info',
  templateUrl: './node-info.component.html',
  styleUrls: ['./node-info.component.scss']
})
export class NodeInfoComponent implements OnInit {


  constructor(private issueService: IssueService) { }

  ngOnInit() {
    this.issueService.getHosts().subscribe((hosts) => {
      console.log(hosts);
 });
  }

}
