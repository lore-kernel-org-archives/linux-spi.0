From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 15:32:56 -0700
Message-ID: <faf455ad-b7ef-beac-ac6d-4822f350cd71@infradead.org>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
 <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
 <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
 <20170925192256.bmrm6gmb4idvomxb@sirena.org.uk>
 <156431d9-a518-53e7-17d9-bb1ee0f637bb@infradead.org>
 <20170925194417.bjkw5ar6s57bkbdt@sirena.org.uk>
 <c0c60c5e-d06f-b246-fb63-3eb507c62449@infradead.org>
 <20170925211154.j23g4b2xmu4f3cxc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Baolin Wang <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170925211154.j23g4b2xmu4f3cxc-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/25/17 14:11, Mark Brown wrote:
> On Mon, Sep 25, 2017 at 12:53:20PM -0700, Randy Dunlap wrote:
>> On 09/25/17 12:44, Mark Brown wrote:
> 
>>> That would then get in the way of build test coverage.  
> 
>> I don't agree, but whatever. I give up.
> 
> OK.  Just as a general thing it's really important that dependency
> changes be thought through and express what the constraints are in ways
> that reflect what's actually going on and what's useful for users, it
> seems to be a frequent problem and it does get in the way.

Yes, it's a frequent problem that drivers do not build due to some kconfig
dependency issue(s).

I would prefer to see the driver maintainer(s) fix build errors themselves,
but they are not always aware of the idiosyncrasies of kconfig.

I think that people often submit drivers (or driver changes) after building
it in one (working) configuration only, without regard for the other possible
combinations.


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
