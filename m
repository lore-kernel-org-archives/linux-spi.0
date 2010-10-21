From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 08/12] gpio: add ti-ssp virtual gpio driver
Date: Thu, 21 Oct 2010 19:40:44 -0400
Message-ID: <4CC0CF7C.1030908@ti.com>
References: <1287429922-18870-1-git-send-email-cyril@ti.com>	
	<1287429922-18870-9-git-send-email-cyril@ti.com>
	<1287700882.2038.135.camel@helium>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
        "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287700882.2038.135.camel@helium>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

On 10/21/2010 06:41 PM, David Brownell wrote:
> On Mon, 2010-10-18 at 15:25 -0400, Cyril Chemparathy wrote:
>> This patch adds a GPIO driver based on TI's SSP device.  This driver does not
>> support GPIO-IRQs.
> 
> Doesn't look particularly evil, except I don't much like the notion of
> needing a "stack" if it's not being used like an MFD where numerous
> functions are accessed concurrently, better IMO to just have each
> function's driver bind exclusively to the chip (and drive it in the
> mode it supports -- SPI, GPIO etc).

SPI and GPIO are not the only modes that this hardware can be programmed
to behave in.  In future, other functions may be added as needed.  I
thought it would be best to keep the shared stuff reusable.

> Also, the patch description is weak/confusing.  First, there's not a
> thing "virtual" about this.  Second, just say that this GPIO driver is
> bypassing pretty much everything in the SSP module (notably, all the
> silicon support for serial protocols) and just driving some of the
> pins as GPIOs.  (Right?)

Sure.

[...]
>> +config GPIO_TI_SSP
>> +	tristate "TI SSP Controller GPIO Driver"
>> +	depends on GPIOLIB && TI_SSP
>> +	help
>> +	  Say yes here to support a virtual GPIO interface on TI SSP ports.
>> +	  Each SSP port translates into 4 GPIOs, with no IRQ support.
> 
> Don't emphasize the "no IRQ part so much; lots of GPIOs don't do IRQs.
> If a board uses SSP this way, it won't care; Kconfig users have no
> control over such board wiring issues.

Agreed.

Thanks
Cyril.
