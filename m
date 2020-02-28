From: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Date: Fri, 28 Feb 2020 15:06:58 +0530
Message-ID: <20200228093658.zc3uifqg4zruokq3@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-7-p.yadav@ti.com>
 <20200227175841.51435e3f@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200227175841.51435e3f-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris,

On 27/02/20 05:58PM, Boris Brezillon wrote:
> On Wed, 26 Feb 2020 15:06:58 +0530
> Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:
> 
> > Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> > on each clock edge as opposed to on each clock cycle. Make
> > framework-level changes to allow supporting flashes in DTR mode.
> > 
> > Right now, mixed DTR modes are not supported. So, for example a mode
> > like 4S-4D-4D will not work. All phases need to be either DTR or STR.
> 
> Didn't go deep into the patch but at first glance you don't seem to
> extend the framework to support stateful modes as I tried to do here
> [1]. That's really something we should address before considering
> supporting xD-xD-xD modes, unless the SPI-NOR only supports one
> stateful mode. If we don't do that first, we might face all sort of
> unpleasant issues:
> 
> * kexec not working correctly because the previous kernel left the NOR
>   in an unknown state
> * suspend/resume not working properly
> * linux not booting properly because the bootloader left the device in
>   its non-default mode
> * ...

Correct. I am working on a follow-up series that takes care of these 
problems. The series will allow spi-nor to detect what mode the flash is 
in and then run the SFPD procedure in that mode (or maybe switch to 
single SPI mode and then go about its business as usual? I haven't 
figured out all the details yet).

So for the context of this series, assume we are handed the flash in 
single SPI mode.
 
> [1]https://patchwork.kernel.org/cover/10638055/

BTW, I took a quick look at this series but I don't see any code that 
tries to detect which mode the flash is in (which is the troublesome 
part [0]). So, for example, if the bootloader leaves the flash in 
8D-8D-8D mode, how would your series handle that situation?

[0] There are multiple problems to take care of when trying to detect 
    which mode a flash is in. We can try reading SFDP in each mode and 
    whichever mode gives us the correct "SFDP" signature is the mode the 
    flash is in. But the problem is that even in xSPI standard Read SFDP 
    command is optional in 8D-8D-8D mode, let alone non-xSPI flashes. 
    Another problem is that the address bytes and dummy cycles for Read 
    SFDP are not the same for every flash. The xSPI standard says 
    address bytes can be 3/4 and dummy cycles can be 8/20. So, for 
    example, Cypress s28hs/s28ht family and Micron Xccela (mt35x) family 
    use 4 address bytes, but the Adesto ATXP032/ATXP032R flashes use 3 
    address bytes.

    Say that a flash supports Read SFDP in 8D-8D-8D mode and we try all 
    the combinations to find out which mode the flash is in, we now have 
    the problem of actually identifying the flash. Unfortunately, the 
    Read ID command is not uniform across flash vendors. The Micron 
    Xccela flashes use 8 dummy cycles and no address bytes for Read ID. 
    The Cypress s28hs/t family uses configurable dummy cycles 
    (defaulting to 3) and needs 4 dummy address bytes all of which are 
    0.

    If we can't find out which flash it is, we can't run its fixup 
    hooks, and might end up running it with incorrect settings. And all 
    this is assuming a flash even has SFDP and has it available in all 
    modes.

    So, the only solution I can now think of is having the flash name in 
    its compatible string in the device tree. This way we can skip all 
    the Read ID ugliness and can have flash-specific hooks to make it 
    easier to detect the mode it is in (though I wonder if it is even 
    possible to detect the mode in a flash that doesn't have SFDP in 
    8D-8D-8D).

    Thoughts? Is there a better way to solve this problem that I didn't 
    think of?

-- 
Regards,
Pratyush Yadav
Texas Instruments India
