From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2, 1/1] mtd: devices: m25p80: Add PM suspend resume
 support
Date: Mon, 28 Nov 2016 17:35:02 -0800
Message-ID: <ad1d08cf-4846-9b77-f8c0-149edb17b7e5@gmail.com>
References: <1473710494-4084-1-git-send-email-kdasu.kdev@gmail.com>
 <4fe502a4-ee01-3fb8-6697-161de814596e@atmel.com>
 <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/24/2016 11:18 AM, Kamal Dasu wrote:
> 
> Cyrille,
> 
> On Mon, Oct 17, 2016 at 1:08 PM, Cyrille Pitchen
> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org <mailto:cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>> wrote:
> 
>     Hi Kamal,
> 
>     Le 12/09/2016 à 22:01, Kamal Dasu a écrit :
>     > Adding PM support so as to be able to probe spi-nor flash
>     > on resume. There are vendor specific commands to setup
>     > the transfer mode and enable read/write as part of
>     > spi_nor_scan(), done on initial probe and needed on resume().
>     > The spi-nor structure is private to the m25p driver and hence
>     > is the only place this can be done without having to duplicate
>     > code in controller driver.
> 
>     Just to be sure I've understood the purpose of this patch: here we
>     suppose
>     that the SPI NOR memory power supply was cut when the CPU entered
>     its suspend
>     mode. So when the CPU is resumed, the SPI NOR memory power supply is
>     enabled
>     again as well and the internal state of the memory is reset.
> 
> 
> Memory could be intact and in refresh state. But generally the spi nor
> part might be powered down. 
> 
> 
>     Depending on the manufacturer, we may need to send dedicated
>     commands so the
>     memory is ready again (for instance, a Global Unlock Block command
>     for SST
>     memories so we can perform Sector Erase and Page Program operations).
>     Those commands are sent from spi_nor_scan(). Hence you call
>     spi_nor_scan()
>     once again from the resume callback.
> 
> 
> Yes there are are chain of calls that setup the state of the part from
> spi_nor_scan that are vendor specific based on the jdec id. So yes some
> of the unlock commands need to be sent before we can start using the
> part again.
>  
> 
>     If so, your patch does make sense but I wonder whether some
>     operations done
>     inside spi_nor_scan() and not related to the memory itself but more
>     to other
>     layers like mtd (struct mtd_info) could always be safely performed a
>     second
>     time. I don't know if that issue already exists or would ever exist,
>     if so
>     it might be interesting to find a mean to tell spi_nor_scan()
>     whether it's
>     called for the first time on this memory (boot) or not (resume).
> 
> 
> I do see the mtd settings that could be done a second time but should
> not cause any issues IMHO.  I don't see a need to distinguish between a
> (re)boot or a resume  and complicate the code. Unless somebody can point

Cyrille, are you okay with Kamal's response? I just saw the 4.10 pull
request pass by and since this patch was still in flight, it did not get
included, can it be queued for 4.11 or is there something else to work on?
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
