From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Thu, 26 Nov 2009 11:18:23 -0700
Message-ID: <fa686aa40911261018u6c1624a7i636140707c4c0b61@mail.gmail.com>
References: <200911161742.46663.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<200911261827.38405.to-fleischer@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
To: Torsten Fleischer <to-fleischer@t-online.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <200911261827.38405.to-fleischer@t-online.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 26, 2009 at 10:27 AM, Torsten Fleischer
<to-fleischer@t-online.de> wrote:
> On Thu, Nov 26, 2009 at 13:12:04 Anton Vorontsov wrote:
> [...]
>> > Ah. =A0I understand what you're doing now. =A0 Hmmm. =A0This approach
>> > concerns me because it relies on firmware or platform code to get CS
>> > gpios set up properly before the driver is probed.
>>
>> Yes, that was said at the very beginning of this thread.
>>
>> > =A0Firmware doesn't
>> > always get it right, and I prefer to avoid platform specific setups as
>> > much as possible. =A0Why can't the CS polarity be encoded into the
>> > device tree so the driver *does* have the polarity data at probe time?
>>
>> We have the spi-cs-high property, but it duplicates compatible
>> property. 'compatible' is enough to tell whether some device has
>> cs-high or cs-low (device's driver knows that already).
>>
>> The problem is that SPI bus master doesn't know all the devices,
>> so it can't extract that information from the compatible string.
>> To workaround that we can use 'spi-cs-high', but that's ugly
>> workaround.
>>
>> SPI modes (0,1,2,3) is another matter, some devices can work in
>> several modes, so 'spi-cpol' and 'spi-cpha' are actually useful.
>>
> To get a sane initial state the needed GPIOs can be set to be inputs duri=
ng
> the driver's initialization.
> This requires pull-up/pull-down resistors connected to the chip select
> lines. I think we can assume that they exist, because the GPIOs are all i=
nputs
> after the controller's hardware reset and the resistors are needed to hav=
e a
> well-defined voltage level on the chip select lines. Normally the level i=
s set
> so that the devices are disabled.
>
> Therefore, it doesn't matter if the firmware sets the GPIOs wrong.

No, that's just shifting responsibility from firmware to hardware.
There is just as much broken hardware out there as broken firmware.
The assumption cannot be made that the initial state of the pin is the
inactive state of the CS line.  Plus, some GPIO pins are output only
and the inital state cannot be read.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
