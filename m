From: Siegbert Baude <siegbert.baude-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] SPI: DaVinci SPI Driver
Date: Thu, 03 Sep 2009 21:48:30 +0200
Message-ID: <4AA01D8E.7090609@gmx.de>
References: <1251834668-32246-1-git-send-email-s-paulraj@ti.com>
	<281fb76e0909030725k1f82b9d5wca1d22e3f3417af4@mail.gmail.com>
	<0554BEF07D437848AF01B9C9B5F0BC5D923DA4D0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <0554BEF07D437848AF01B9C9B5F0BC5D923DA4D0-bGftbgMkZa+IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sandeep.


Paulraj, Sandeep schrieb:
>> On Behalf Of siegbert.baude-Mmb7MZpHnFY@public.gmane.org

>> I had another look at your code and am wondering about the correctness
>> of more comments, and  I wonder about error handling in the ISR:

>> 2009/9/1  <s-paulraj-l0cyMroinI0@public.gmane.org>:
>>> From: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
>>> + * davinci_spi_bufs - functions which will handle transfer data
>>> + * @spi: spi device on which data transfer to be done
>>> + * @t: spi transfer in which transfer info is filled
>>> + *
>>> + * This function will put data to be transferred into data register
>>> + * of SPI controller and then wait untill the completion will be marked
>>> + * by the IRQ Handler.
>>> + */
>> Is this true? For me the code seems to be polling in the transmit
>> case. Look down: 

> [Sandeep] if you look at 
> http://focus.ti.com/lit/ug/sprued4b/sprued4b.pdf
> page 26 , there is no TXINTFLAG to complement the RXINTFLAG
> and if you have a look at page 19, there is no support for transmit interrupt

You're right about that. I was not questioning your code. That seems to 
be o.k. for me (without having tested it). I was questioning your 
comment on top of the function, as it describes something, that is not 
implemented in your function. Only one out of three possible code paths 
use interrupts, so the comment should reflect the other two polling 
paths, too.

>>> + * davinci_spi_irq - probe function for SPI Master Controller
>>> + * @irq: IRQ number for this SPI Master
>>> + * @context_data: structure for SPI Master controller davinci_spi
>>> + *
>>> + * ISR will determine that interrupt arrives either for READ or WRITE
>> command.
>>> + * According to command it will do the appropriate action. It will
>> check
>>> + * transfer length and if it is not zero then dispatch transfer command
>> again.
>>> + * If transfer length is zero then it will indicate the COMPLETION so
>> that
>>> + * davinci_spi_bufs function can go ahead.
>>> + */

>> I can't find anything in the below ISR code with regard to differing
>> between READ and WRITE or checking transfer lengthes.

> [Sandeep] as I have mentioned above we do not have a transmit interrupt

Again, my remark was only about the comment describing the ISR. That one 
is not in accordance with your actual implementation.

>>> +static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
>>> +{
>>> +       struct davinci_spi *davinci_spi = context_data;
>>> +       u32 int_status, rx_data = 0;
>>> +       irqreturn_t ret = IRQ_NONE;
>>> +
>>> +       int_status = ioread32(davinci_spi->base + SPIFLG);
>>> +       while ((int_status & SPIFLG_MASK) != 0) {

>> SPIFLG_MASK is many more bits than just the interrupt flag. If you got
>> an OVRNINTFLG set, you will never end this loop, as you do not reset
>> this flag in davinci_spi_check_error()! In addition you would
>> acknowledge the interrupt, even if you just got an error and actually
>> another interrupt handler would have been responsible for the
>> interrupt that just occurred.
>> Because of the last argument I would move down the next line into the
>> following if-clause.

> [Sandeep] Yes that's correct

So here, it's the code that must be changed.

Best regards
Siegbert
