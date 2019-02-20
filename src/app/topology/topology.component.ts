import { Component, OnInit, Input } from '@angular/core';
import {Router} from '@angular/router';
import { ViewChild, ElementRef } from '@angular/core';
import {IssueService} from '../issue.service'; 
import {Issue} from '../issue.model';
import {MatToolbarModule, MatFormFieldModule, MatInputModule, MatOptionModule, MatSelectModule, MatIconModule, MatButtonModule,MatCardModule,  MatTableModule, MatDividerModule, MatSnackBarModule } from '@angular/material';

declare var $:any;

@Component({
  selector: 'app-topology',
  templateUrl: './topology.component.html',
  styleUrls: ['./topology.component.scss']
})
export class TopologyComponent implements OnInit {

  issues: Issue[];

  @Input() width = 512;
  @Input() height = 418;
  @ViewChild('myCanvas', {read: ElementRef}) myCanvas: ElementRef;
  public context: CanvasRenderingContext2D;


  constructor(private issueService: IssueService) { }

  ngOnInit() {
          //canvas method for the lines between the nodes

    this.context = (<HTMLCanvasElement>this.myCanvas.nativeElement).getContext('2d');
    (<HTMLCanvasElement>this.myCanvas.nativeElement).width = this.width;
    (<HTMLCanvasElement>this.myCanvas.nativeElement).height = this.height;
      this.context.beginPath();
      this.context.moveTo(0,0);
      this.context.lineTo(300,150);
      this.context.lineTo(-300,150);

      this.context.stroke(); 
    
    //hide and show the packet and optical nodes

    $(document).ready(function(){
      $("#hide").click(function(){
          $("p").hide();
      });
      $("#show").click(function(){
          $("p").show();
      });

      
      

  });

  // this.issueService.getIssues().subscribe((issues) => {
  //       console.log(issues);
  //  });

  this.fetchIssues();

  }

  fetchIssues(){
    this.issueService
    .getIssues()
    .subscribe((data: Issue[]) => {
      this.issues = data;
      console.log(this.issues);
      console.log(this.issues[0].nodes[0].node_id);
      
      console.log(this.issues[0].nodes[0].node_name);
    })
  }

}
