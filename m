From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/8] spi: bcm-qspi: Add Broadcom MSPI driver
Date: Fri, 19 Aug 2016 11:20:05 -0400
Message-ID: <CAC=U0a1uW3pB0MA1Hmw9_pKTrBhnHKmz7gquih2r5zSUO_SAoA@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-3-git-send-email-kdasu.kdev@gmail.com> <20160816181536.GX9347@sirena.org.uk>
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
        <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816181536.GX9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Aug 16, 2016 at 2:15 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 06:13:07PM -0400, Kamal Dasu wrote:
>
>> +static int bcm_qspi_transfer_one(struct spi_master *master,
>
>> +             if (qspi->next_udelay) {
>> +                     udelay(qspi->next_udelay);
>> +                     qspi->next_udelay = 0;
>> +             }
>
> Why is the driver manually implementing delays in a transfer_one()
> function?  The core will add any required delays between transfers, this
> will result in us delaying twice.
>
>> +             read_from_hw(qspi, slots);
>> +             if (qspi->cs_change) {
>> +                     usleep_range(10, 20);
>> +                     qspi->cs_change = 0;
>> +             }
>
> Similarly here, the core will do chip select changes.
>
>> +     if (spi_transfer_is_last(master, trans))
>> +             hw_stop(qspi);
>
> The only thing I can see that looks like it might make a difference here
> is this hw_stop() operation but all that does is update an internal
> state machine so there's no limitation on it needing to be done before
> the above operations that I can see.


I will cleanup  above 3 areas of redundant code.

>> +     ret = clk_prepare_enable(qspi->clk);
>> +     if (ret) {
>> +             dev_err(dev, "failed to prepare clock\n");
>> +             goto err2;
>
> Please use named labels rather than numbered, it makes life a lot easier
> if anything gets changed.
>

Ok will make this change as well

>> +EXPORT_SYMBOL_GPL(bcm_qspi_probe);
>
> This needs some explanation or to be added along with the user.
>

Will add appropriate comments for the user.

>> diff --git a/drivers/spi/spi-brcmstb-qspi.c b/drivers/spi/spi-brcmstb-qspi.c
>> new file mode 100644
>> index 0000000..c7df92e
>> --- /dev/null
>> +++ b/drivers/spi/spi-brcmstb-qspi.c
>
> This should really be a separate patch, it's a separate driver and very
> surprising to find it here.

Its very specific to the spi-block and hence is here, I will separate the patch,

Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
