From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
	Device Tree
Date: Tue, 18 Sep 2012 14:08:12 +0200
Message-ID: <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
	<1347016499-29354-10-git-send-email-lee.jones@linaro.org>
	<CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com>
	<505757D8.8090405@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <505757D8.8090405-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 17, 2012 at 7:03 PM, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org> wrote:
> On 09/10/2012 01:11 PM, Linus Walleij wrote:
>>
>> It appears Roland has written his bindings such that DT
>> data augments platform data (yes, I am also getting crazy
>> about this prioritization, mea culpa for ACKing this without
>> proper discussion) so it appears that you could actually
>> use AUXDATA and some stuff in the DT at the same
>> time.
>
> Sorry for the incompleteness of the devicetree conversion. I'm sending a
> patch (separately) that makes it possible to specify everything via
> devicetree, so you can choose between dt and platform data.

OK it was not such a big deal, but many many thanks for fixing this
up! :-)

> Except in case of callback specification (dma_filter()), you need to
> provide platform data.

OK.

> Interestingly, when I removed the actual platform data from the board
> file, I noticed that I still needed to specify a device name (like
> dev:ssp0) to make it work. But this seems to be expected according to
> the documentation of OF_DEV_AUXDATA(). Are there any plans or ideas how
> to fix this?

This is very likely because the clock tree has a name like "dev:ssp0"
encoded for this device, and if you don't nail it down like that the
device name will be the same as the node in your device tree and
then clock lookup will fail.

The "real fix" is to convert the clock drivers to use device tree so
the drivers can just refer to the phandles to figure out what clock
node they need.

Along with the DMA channel mapping this is one of the major
roadblocks to finalizing the device tree adoptions.

> When we have sorted out this driver change (please check the new pl022
> specific dt property names!), I will provide patches for arm-soc to
> actually use this new interface via dts files.

OK cool I guess you will do this for the LPC32xx? Or are you testing
this on some other platforms?

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
