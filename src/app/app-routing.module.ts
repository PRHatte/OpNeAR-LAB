import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TopologyComponent } from './topology/topology.component';
import { NodeInfoComponent } from './node-info/node-info.component';
import { EthernetInfoComponent } from './ethernet-info/ethernet-info.component';


const routes: Routes = [
  {path :'topology' , component: TopologyComponent},
  {path :'nodeInfo' , component: NodeInfoComponent},
  {path :'ethernetInfo' , component: EthernetInfoComponent},
  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
