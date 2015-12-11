From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 2/5] spi: core: add spi_replace_transfers method
Date: Fri, 11 Dec 2015 17:04:23 +0100
Message-ID: <E4196FDC-4E6D-430F-973D-5E447FF7707E@martin.sperl.org>
References: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org> <1449501708-2228-3-git-send-email-kernel@martin.sperl.org> <CAHp75Vd_7NBibKFPq++JuDiWp9zkwu9iPrjZyKK6XoL6Lr_S0g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vd_7NBibKFPq++JuDiWp9zkwu9iPrjZyKK6XoL6Lr_S0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 11.12.2015, at 15:37, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> On Mon, Dec 7, 2015 at 5:21 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> +/* Core methods for spi_message alterations */
>> +
>> +static void __spi_replace_transfers_release(struct spi_master *master,
>> +                                           struct spi_message *msg,
>> +                                           void *res)
>> +{
>> +       struct spi_replaced_transfers *srt = res;
> 
> srt sounds magic
> rxfer might be better?
srt = Spi_Replaced_Transfer - if you like rxfer better I can replace it.

> 
>> +       int i;
> 
> unsigned int i; or size_t to be in align with inserted field.
will do.

>> +       int i;
> 
> Ditto.
> 
>> +
>> +       /* allocate the structure using spi_res */
>> +       srt = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
>> +                           insert * sizeof(struct spi_transfer)
>> +                           + sizeof(struct spi_replaced_transfers)
>> +                           + extradatasize,
>> +                           0);
>> +       if (!srt)
>> +               return NULL;
> 
> ERR_PTR for this API seems better to have.
Can do that.

>> +       srt->inserted = insert;
>> +       for (i = insert - 1; i >= 0 ; i--) {
> 
> This is classical pattern for
> 
> while (--insert >= 0) {
> }
did it slightly differently as size_t is always >= 0 - 
the main reason for using int here...

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
