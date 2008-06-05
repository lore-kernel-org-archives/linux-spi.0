From: Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP
 Mobile Data Protection System 3D ACPI	driver
Date: Thu, 05 Jun 2008 10:28:53 +0200
Message-ID: <4847A3C5.60600@tremplin-utc.net>
References: <1212235533.3815.5.camel@localhost> <48479922.6050003@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Yan Burman <burman.yan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	HWMON <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pau-FPnfh0goHpsdnm+yROfE0A@public.gmane.org
To: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48479922.6050003-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Riku Voipio wrote:
> Yan Burman wrote:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Supported chips:
>> +
>> +  * STMicroelectronics LIS3LV02DL and LIS3LV02DQ
>> +
> These chips are connected to either I2C or SPI - This is the 4th driver f=
or
> (apparently) these same chips:
> =

> http://docwiki.gumstix.org/Lis3lv02dq_spi.c
> http://svn.openmoko.org/branches/src/target/kernel/2.6.24.x/patches/lis30=
2dl.patch =

> =

> http://article.gmane.org/gmane.linux.kernel.spi.devel/1010
Hi!
Thanks a lot for these links (which I was not aware of). They indeed =

seem to handle the same hardware (all via spi). To be even more =

complete, here is a link we received off-list for accessing the same =

hardware via I=B2C:
http://pof.eslack.org/HTC/shift/i2c-gsensor.tar.gz

There are for sure some nice things we could borrow ;-)
> =

>> +    depends on ACPI && INPUT && X86
>>   =

> =

> =

>> +/* The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ
>> + * that seems to be connected via SPI */
>>   =

> Perhaps it would make more sense implement support for SPI
> bus on the laptop and use the SPI interface directly instead or
> routing via the ACPI hiding layer?
Getting rid of ACPI could be nice, as it tends to be rather slow. =

However, so far we've stick to it because it ensures that for the ~15 =

different models of HP laptop, we can access the hardware exactly the =

same way. I have the gut feeling that if HP spent some time to add an =

interface in ACPI, there was some kind of reason.

However, I know nothing about SPI. Maybe you'll tell that if this chip =

is on the SPI bus, it will always be accessed the same way, located at =

the same address... or whatever that can ensure us that from the moment =

we know this device is in the laptop (and that's easy via HPQ0004) we =

cannot mess up. In that case, going to SPI would be definitely worthy.

Eric

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
