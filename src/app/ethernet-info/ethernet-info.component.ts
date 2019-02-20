import { Component, OnInit } from '@angular/core';
import {IssueService} from '../issue.service'; 


@Component({
  selector: 'app-ethernet-info',
  templateUrl: './ethernet-info.component.html',
  styleUrls: ['./ethernet-info.component.scss']
})
export class EthernetInfoComponent implements OnInit {


  constructor(private issueService: IssueService) { }

  ngOnInit() {
    this.issueService.getSites().subscribe((sites) => {
      console.log(sites);
 });
  }

}
