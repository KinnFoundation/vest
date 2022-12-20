"reach 0.1";
"use strict";
// -----------------------------------------------
// Name: KINN Vest
// Version: 0.1.0 - vest initial
// Requires Reach v0.1.11-rc7 (27cb9643) or later
// ----------------------------------------------

import {
  State as BaseState,
  Params as BaseParams,
  TokenState,
  Triple,
  fState
} from "@KinnFoundation/base#base-v0.1.11r15:interface.rsh";

// TYPES

export const VestState = Struct([
  ["tokenSupply", UInt],
  ["who", Address],
  ["withdraws", UInt],
  ["terrain", Triple(UInt)],
  ["frozen", Bool],
  ["lastConcensusTime", UInt],
  ["vestUnit", UInt],
  ["vestPeriod", UInt],
  ["managerEnabled", Bool],
  ["recipientEnabled", Bool],
  ["delegateEnabled", Bool],
  ["anybodyEnabled", Bool],
]);

export const State = Struct([
  ...Struct.fields(BaseState),
  ...Struct.fields(TokenState),
  ...Struct.fields(VestState),
]);

export const VestParams = Object({
  tokenAmount: UInt, // amount of tokens to vest
  recipientAddr: Address, // address of the recipient
  delegateAddr: Address, // address of the delegate
  cliffTime: UInt, // cliff network seconds
  vestTime: UInt, // vesting network seconds
  vestPeriod: UInt, // vesting minimum period
  vestMultiplierD: UInt, // vesting multiplier (delegate)
  vestMultiplierA: UInt, // vesting multiplier (anybody)
  defaultFrozen: Bool, // default frozen
  managerEnabled: Bool, // manager enabled
  recipientEnabled: Bool, // recipient enabled
  delegateEnabled: Bool, // delegate enabled
  anybodyEnabled: Bool, // anybody enabled
});

export const Params = Object({
  ...Object.fields(BaseParams),
  ...Object.fields(VestParams),
});

// FUN

const fTouch = Fun([], Null);
const fToggle = Fun([], Null);
const fCancel = Fun([], Null);
const fWithdraw = Fun([], Null);
const fDelegateWidthdraw = Fun([], Null);
const fAnybodyWithdraw = Fun([], Null);

// REMOTE FUN

export const rState = (ctc, State) => {
  const r = remote(ctc, { state: fState(State) });
  return r.state();
};

export const rWithdraw = (ctc) => {
  const r = remote(ctc, { withdraw: fWithdraw });
  return r.withdraw();
};

// API

export const api = {
  touch: fTouch,
  toggle: fToggle,
  cancel: fCancel,
  withdraw: fWithdraw,
  delegateWithdraw: fDelegateWidthdraw,
  anybodyWithdraw: fAnybodyWithdraw,
};

// CONTRACT

export const Event = () => [];
export const Participants = () => [];
export const Views = () => [];
export const Api = () => [];
export const App = (_) => {
  Anybody.publish();
  commit();
  exit();
};
// ----------------------------------------------
