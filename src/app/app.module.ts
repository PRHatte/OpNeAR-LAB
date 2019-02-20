import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { TopologyComponent } from './topology/topology.component';
import { NodeInfoComponent } from './node-info/node-info.component';
import {MatToolbarModule, MatFormFieldModule, MatInputModule, MatOptionModule, MatSelectModule, MatIconModule, MatButtonModule,MatCardModule,  MatTableModule, MatDividerModule, MatSnackBarModule } from '@angular/material';
import { EthernetInfoComponent } from './ethernet-info/ethernet-info.component';
import { HttpClientModule } from '@angular/common/http';
import {IssueService} from './issue.service';

@NgModule({
  declarations: [
    AppComponent,
    TopologyComponent,
    NodeInfoComponent,
    EthernetInfoComponent
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    RouterModule,
    MatToolbarModule,
    MatFormFieldModule,
    MatInputModule,
    MatOptionModule,
    MatSelectModule,
    MatIconModule,
    MatButtonModule,
    MatCardModule, 
    MatTableModule,
    MatDividerModule,
    MatSnackBarModule,
    HttpClientModule
    
  ],
  providers: [IssueService],
  bootstrap: [AppComponent]
})
export class AppModule { }
