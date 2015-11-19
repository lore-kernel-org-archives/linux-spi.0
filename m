From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: spi: OF module autoloading is still broken
Date: Thu, 19 Nov 2015 09:47:18 -0300
Message-ID: <564DC4D6.2010506@osg.samsung.com>
References: <56104E88.3040807@gmail.com> <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com> <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com> <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com> <564A101F.9090807@osg.samsung.com>
 <20151116192434.GO8456@google.com> <564A35EB.5080008@osg.samsung.com>
 <20151116204702.GP8456@google.com> <564A4B66.6090107@osg.samsung.com>
 <564CDA72.8030800@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-mtd@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564CDA72.8030800@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

On 11/18/2015 05:07 PM, Javier Martinez Canillas wrote:
> Hello Brian and Mark,
> 
> On 11/16/2015 06:32 PM, Javier Martinez Canillas wrote:
>> On 11/16/2015 05:47 PM, Brian Norris wrote:
>>> On Mon, Nov 16, 2015 at 05:00:43PM -0300, Javier Martinez Canillas wrote:
>>>> On 11/16/2015 04:24 PM, Brian Norris wrote:
> 
> [snip]
> 
>>>>> I don't think you have problems only with bad FDTs. I think you have a
>>>>> problem with perfectly valid DTs.
>>>>>
>>>>
>>>> Agreed, I wonder if spi_uevent() shouldn't be changed to report both the
>>>> OF and old SPI modaliases to avoid breaking a lot of drivers but at the
>>>> same time allowing DT-only drivers to not need an SPI ID table.
>>>
>>> That's the solution I imagined, though I haven't tested it yet. I don't
>>> see much precedent for reporting multiple modaliases, so there could be
>>> some kind of ABI issues around that too.
>>>
>>
>> Ok, I'm glad that we agree. This definitely needs to be discussed with more
>> people. I'll re-spin my patch and post a v2 reporting multiple modaliases
>> tomorrow after testing.
>>
> 
> So I had some time today to test this approach but unfortunately it seems
> this workaround will not be possible because AFAICT kmod only takes into
> account the last MODALIAS reported as a uevent. I still have to check the
> kmod source code but that's my conclusion from trying to report both aliases.
>

I dig a little more on this and is udev and not kmod that can't cope with
more than one MODALIAS, kmod just use the alias that udev tells it to use.

1) OF modalias reported after SPI modalias
------------------------------------------

cat /sys/devices/platform/12d40000.spi/spi_master/spi2/spi2.0/uevent
DRIVER=cros-ec-spi
OF_NAME=cros-ec
OF_FULLNAME=/spi@12d40000/cros-ec@0
OF_COMPATIBLE_0=google,cros-ec-spi
OF_COMPATIBLE_N=1
MODALIAS=spi:cros-ec-spi
MODALIAS=of:Ncros-ecT<NULL>Cgoogle,cros-ec-spi

udevadm test /sys/devices/platform/12d40000.spi/spi_master/spi2/spi2.0
ACTION=add
DEVPATH=/devices/platform/12d40000.spi/spi_master/spi2/spi2.0
DRIVER=cros-ec-spi
MODALIAS=of:Ncros-ecT<NULL>Cgoogle,cros-ec-spi
OF_COMPATIBLE_0=google,cros-ec-spi
OF_COMPATIBLE_N=1
OF_FULLNAME=/spi@12d40000/cros-ec@0
OF_NAME=cros-ec
SUBSYSTEM=spi
USEC_INITIALIZED=52732787
run: 'kmod load of:Ncros-ecT<NULL>Cgoogle,cros-ec-spi'

2) SPI modalias reported after OF modalias
------------------------------------------

cat /sys/devices/platform/12d40000.spi/spi_master/spi2/spi2.0/uevent
DRIVER=cros-ec-spi
OF_NAME=cros-ec
OF_FULLNAME=/spi@12d40000/cros-ec@0
OF_COMPATIBLE_0=google,cros-ec-spi
OF_COMPATIBLE_N=1
MODALIAS=of:Ncros-ecT<NULL>Cgoogle,cros-ec-spi
MODALIAS=spi:cros-ec-spi

udevadm test /sys/devices/platform/12d40000.spi/spi_master/spi2/spi2.0
ACTION=add
DEVPATH=/devices/platform/12d40000.spi/spi_master/spi2/spi2.0
DRIVER=cros-ec-spi
MODALIAS=spi:cros-ec-spi
OF_COMPATIBLE_0=google,cros-ec-spi
OF_COMPATIBLE_N=1
OF_FULLNAME=/spi@12d40000/cros-ec@0
OF_NAME=cros-ec
SUBSYSTEM=spi
USEC_INITIALIZED=288316488
run: 'kmod load spi:cros-ec-spi'

So as you can see: 'kmod load $modalias' is only called for the last modalias.
 
> 
> IOW, even when is possible to report more than one MODALIAS, user-space seems
> to only use the last one reported so using both don't work.
> 
> Of course kmod can be changed to check for more than one MODALIAS but since
> the kernel should not break old user-space, the fact that a single MODALIAS
> was reported seems to be an ABI now due how is used.
>

So I think our options are:

a) Not change spi_uevent() to report an OF modalias and make a requirement
to have a spi_device_id table even for OF-only to have autoload working.

Regardless of the option, SPI ID tables should be present in drivers so
these are supported in non-OF platforms as Mark said.

b) Make sure that all OF drivers have a complete OF table with all entries
in the SPI ID table before spi_uevent() is modified to report OF modaliases.

My preference would be b) so the same table (OF or SPI ID) can be used for
alias filling that match reported modalias and driver to device matching
and will also be aligned with what other subsystems do.

I'll check my script to see why the drivers/mtd/devices/m25p80.c was not
found, likely because the entries in the spi_device_id table weren't in
the DT binding doc before.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
