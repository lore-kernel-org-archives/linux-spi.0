From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: xilinx: Detect stall with Unknown commands
Date: Wed, 22 Nov 2017 20:27:50 +0100
Message-ID: <CAPybu_2N1nOLoTLbDmaeyO6ERG=LiydsHyNCEkX6_BkXaV4daQ@mail.gmail.com>
References: <20171121090904.6901-1-ricardo.ribalda@gmail.com>
 <20171122111215.2isnpg3nfry3g3ll@sirena.org.uk> <CAPybu_2MBMFOy+RDSSai1pGf_+A4AD6=gbyWbZSLEPQetjfBxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPybu_2MBMFOy+RDSSai1pGf_+A4AD6=gbyWbZSLEPQetjfBxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi again

On Wed, Nov 22, 2017 at 8:25 PM, Ricardo Ribalda Delgado
<ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Mark
>
>
> On Wed, Nov 22, 2017 at 12:12 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Nov 21, 2017 at 10:09:02AM +0100, Ricardo Ribalda Delgado wrote:
>>
>>> +             stalled = 10;
>>>               while (rx_words) {
>>> +                     if (rx_words == n_words && !(stalled--) &&
>>> +                         !(sr & XSPI_SR_TX_EMPTY_MASK) &&
>>> +                         (sr & XSPI_SR_RX_EMPTY_MASK)) {
>>
>> 10 seems like a small number for what is essentially just a busy spin -
>> are we sure that we won't reasonably hit a case where the CPU is
>> sufficiently fast and the bus sufficiently slow we falsely detect a
>> stall?  Where did this number come from?
>
> This code is executed after all the data has been pushed to the out
> fifo. Since we are not inhibitng tx, the moment the empty mask is
> evaluated,  at least one byte should be out.
>
> After 1 day of use I have been able to locate one event when stalled
> was two. So 10 is very conservative number.
>
> In other words: 10 is one order of magnitude bigger than the worst
> measured case.


If it makes you more comfortable I could add something like

if (n_tries < 8)
   msleep(10);

Regards!

>
> Thanks for your review :)
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
