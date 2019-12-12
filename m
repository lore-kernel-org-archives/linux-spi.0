From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
Date: Thu, 12 Dec 2019 22:08:24 +0100
Message-ID: <70bf4954-d7ab-e300-017c-c743a40162a4@suse.de>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-5-afaerber@suse.de>
 <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
 <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
 <20191212171922.GM4310@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212171922.GM4310@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 12.12.19 um 18:19 schrieb Mark Brown:
> On Thu, Dec 12, 2019 at 04:14:59PM +0100, Andreas Färber wrote:
>> Am 12.12.19 um 09:40 schrieb Geert Uytterhoeven:
>>> On Thu, Dec 12, 2019 at 4:41 AM Andreas Färber <afaerber@suse.de> wrote:
>>>> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
> 
>>>> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
>>>> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".
> 
> Separate patch for this?

For the checkpatch cleanup? Or helpers preparation vs. spi-gpio.c usage?

>> So from that angle I don't see a better way than either duplicating the
>> functions or using some macro magic to #include the header twice. If we
>> wanted to go down that path, we could probably de-duplicate the existing
>> two functions, too, but I was trying to err on the cautious side, since
>> I don't have setups to test all four code paths myself (and a ton of
>> more relevant but less fun patches to flush out ;)).
> 
> Yeah, I don't think there's any great options here with the potential
> performance issues - probably the nicest thing would be to autogenerate
> lots of variants but I think that's far more trouble than it's worth.

Maybe add another code comment to revisit that idea later then?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
