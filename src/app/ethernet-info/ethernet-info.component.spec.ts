import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EthernetInfoComponent } from './ethernet-info.component';

describe('EthernetInfoComponent', () => {
  let component: EthernetInfoComponent;
  let fixture: ComponentFixture<EthernetInfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EthernetInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EthernetInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
