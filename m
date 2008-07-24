From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [Patch 0/4] IndustrialIO subsystem (ADCs, accelerometers etc)
Date: Thu, 24 Jul 2008 11:44:36 +0200
Message-ID: <48884F04.4070403@tremplin-utc.net>
References: <488763AD.4050400@gmail.com> <20080723174801.GC11009@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor@mail.ru>,
	"Hans J. Koch" <hjk@linutronix.de>,
	David Brownell <david-b@pacbell.net>, mgross@linux.intel.com,
	Ben Nizette <bn@niasdigital.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754977AbYGXJpM@vger.kernel.org>
In-Reply-To: <20080723174801.GC11009@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Henrique de Moraes Holschuh schreef:
> On Wed, 23 Jul 2008, Jonathan Cameron wrote:
>> The subsystem is now in a functional state with a small set of drive=
rs:
>>
>> Max1363 (supports numerous Maxim i2c ADC's) (tested with max1363 and=
 max1238 chips)
>>    - Uses a periodic timer to provide ring buffer mode.
>>    - All reads form these devices are scan modes so direct single el=
ement access
>>      is not provided.
>>    - Monitor mode on max1363 is not yet supported (need to do a bit =
debugging of
>>      the board I have so as to be able to test this).
>>
>> ST LIS3L02DQ - SPI accelerometer.
>>    - Uses a datardy interrupt to driver a software ring buffer.
>>    - Most functionality of this device is supported.
>>
>> VTI SCA3000 (tested with an e05)
>>    - Hardware ring buffer.
>=20
> I'd like to see something done to have the common parts of interfaces=
 of the
> same class (e.g. accelerometers) be standard.  Like hwmon does with
> temp#_input, etc.
>=20
> Otherwise you made it easier to write drivers, but did nothing to hel=
p
> userspace to USE the drivers :-)
Hi,
I completely agree with Henrique. There already exist 3 accelerometer=20
drivers in the kernel (and I'm writing a fourth on). What we are=20
desperately in need of is a _user_ interface. So that a generic program=
=20
can pop up and say "Oh, there is an accelerometer on this computer, I'l=
l=20
use it to detect free falls."

IMHO, I think the ADC should have a much more specific and specialised=20
(user and kernel) API corresponding to the accelerometers. Granted, you=
=20
probably had in mind only the accelerometers for industrial usage, but=20
it would be much better if the current accelerometer drivers had a=20
reason to be ported to this new subsystem.

In particular, what I think would be worthy would be:
* Up to 3 pre-defined axes (X, Y, Z) - that's provided by your current=20
version of industrialio
* If the accelerometer is soldered on the computer, define once for all=
=20
to which _physical_ movement corresponds which axis (eg: a laptop on it=
s=20
normal position going up has axis Z increasing).
* Free fall event. Either it's hardware detected, or the accelerometer=20
infrastructure will detect it in software.
* For each axis, what is the maximum and minimum bound and the unit -=20
Probably worthy for the whole ADC infrastructure
* Joystick emulation (calibrated so that when the computer is not=20
moving, all the values are at 0). All the current drivers have it.

That's it for my wish-list for accelerometers :-)


Also, a couple of specific comments on the patches:
* At a quick glance, it seems the VTI SCA3000 driver sends events at 50=
%=20
and 75% ring full, while the ST LIS3L02DQ driver sends events at 50% an=
d=20
100%. Why this difference?
* The accelerometer infrastructure has axis offset and axis gain=20
attributes. However, it seems really specific to the ST accelerometer=20
(and still, I doubt it's useful for most users as those values are=20
factory-set to good values). Shouldn't they be moved to the ST LIS3L02D=
Q=20
driver instead of being part of the accelerometer infrastructure?
* It would be also very good to provide a small userspace program=20
showing how to read an industrialio device (=C3=A0 la evtest).

See you,
Eric
