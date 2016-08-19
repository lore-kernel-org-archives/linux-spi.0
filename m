From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 3/8] spi: bcm-qspi: Add BSPI spi-nor flash controller driver
Date: Fri, 19 Aug 2016 11:33:01 -0400
Message-ID: <CAC=U0a0NkjUQ1gAGNCsLycUhU_x0k=munc4bPTZW1YEW6OY1yw@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-4-git-send-email-kdasu.kdev@gmail.com> <20160816183148.GZ9347@sirena.org.uk>
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
In-Reply-To: <20160816183148.GZ9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Aug 16, 2016 at 2:31 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 06:13:08PM -0400, Kamal Dasu wrote:
>
>> +     bcm_qspi_bspi_lr_start(qspi);
>> +     /* Must flush previous writes before starting BSPI operation */
>> +     mb();
>> +     if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
>
> The comment suggests that the memory barrier is misplaced or that
> there's something missing?
>

Yes it got misplaced during refactoring the code. will move it to the
right place.

>> +             if (retry--)
>> +                     goto retry;
>
> Please write loops using normal C looping constructs rather than goto
> statements, it makes life a lot easier.  I'm not convinced that the loop
> is safe as is with the completion reinitializaiton and so on, we should
> at least be turning off the hardware before we reinitialize the
> completion to avoid races with slow hardware.
>

Actually will get rid of the retry logic.

>> +     io_width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
>
> Normal if statements please.
>

Ok will fix this.

>> +static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
>> +{
>> +     struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
>> +     struct bcm_qspi *qspi = qspi_dev_id->dev;
>> +
>> +     dev_dbg(&qspi->pdev->dev, "BSPI INT error status %x\n",
>> +             qspi_dev_id->irqp->mask);
>
> I'd expect this to be dev_err() or something, but then the message
> claims this an error status and it doesn't seem to actually read that
> from the hardware.
>

Agreed will change this.

>> +#ifdef  QSPI_INT_DEBUG
>> +     /* this interrupt is for debug purposes only, dont request irq */
>> +     {
>> +             .irq_name = "spi_lr_overread",
>> +             .irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
>> +             .mask = INTR_BSPI_LR_OVERREAD_MASK,
>> +     },
>> +#endif
>
> Why not?

Is there in the HW block but will never get triggered,  will never get
triggered in the current driver. But kept it for completeness.

Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
