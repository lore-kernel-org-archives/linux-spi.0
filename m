From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 8/8] spi: nsp-qspi: Add Broadcom NSP, NS2, Cygnus SoC support
Date: Fri, 19 Aug 2016 11:43:24 -0400
Message-ID: <CAC=U0a31LOphD=21-tBtiCxN-JqxSArxqhQ4_=fXwH-vEKnbHA@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-9-git-send-email-kdasu.kdev@gmail.com> <20160816184030.GB9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        vigneshr-l0cyMroinI0@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816184030.GB9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Aug 16, 2016 at 2:40 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 06:13:13PM -0400, Kamal Dasu wrote:
>
>> -             irq = platform_get_irq_byname(pdev, name);
>> +             if (soc && qspi_irq_tab[val].irq_source == MUXED_L1) {
>> +                     /* all mspi, bspi intrs muxed to one L1 intr */
>> +                     irq = platform_get_irq(pdev, 0);
>> +                     of_property_read_string(dev->of_node,
>> +                                             "interrupt-names",
>> +                                             &name);
>> +             }
>
> I am confused why we are parsing the interrupt-names property here?
>

For Muxed L1 single source interrupt, there is only one irq, and  SoCs
could use a different different name wanted to use that name. But I
could force a name as well.

>> +     /*
>> +      * Some SoCs integrate spi controller (e.g., its interrupt bits)
>> +      * in specific ways
>> +      */
>> +     if (soc) {
>> +             qspi->soc = soc;
>> +             soc->bcm_qspi_int_set(soc, MSPI_DONE, true);
>> +     } else {
>> +             qspi->soc = NULL;
>> +     }
>
> The variable name "soc" here doesn't seem hugely descriptive when it's
> just for the interrupt controller.

Named it that way since it could potentially have other SoC specific
settings for spi master bus needed in future.

Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
