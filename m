From: Illia Smyrnov <x0194613-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Thu, 6 Jun 2013 13:08:56 +0300
Message-ID: <51B05FB8.6050903@ti.com>
References: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
	<1370432398-7796-3-git-send-email-illia.smyrnov@ti.com>
	<20130605120346.GZ31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>, Greg,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130605120346.GZ31367-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On 06/05/2013 03:03 PM, Mark Brown wrote:
> On Wed, Jun 05, 2013 at 02:39:58PM +0300, Illia Smyrnov wrote:
>
>>   - The spi slave nodes can provide the following information which is used
>>     by the spi controller:
>>     - ti,spi-turbo-mode: Set turbo mode for this device.
>> +  - ti,spi-fifo-depth: Enable FIFO and set up buffer depth.
>
> Why is this defined for slaves?  Surely the size of the FIFO in the
> controller is a property of the controller not the slave?

According to OMAP TRM [1] the FIFO buffer can be used by only one 
channel at a time. If several channels are selected and several FIFO 
enable bit fields are set to 1, the controller forces the buffer not to 
be used.

If there are several slaves on the controller we must select which of 
slaves will use the FIFO for SPI transfers. Also, optimal FIFO size is 
heavily dependent of the SPI transfers length specific for certain slave.

>
>> +		bytes_per_word = (cs->word_len <= 8) ? 1 :
>> +				(cs->word_len <= 16) ? 2 :
>> +				/* cs->word_len <= 32 */ 4;
>
> This isn't legible.  Use a switch statement, or better yet just divide.
>
>> +		level = (t->len < mcspi->fifo_depth ? t->len :
>> +			mcspi->fifo_depth) - 1;
>> +
>> +		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
>> +			((wcnt << 16) | (level << (is_read ? 8 : 0))));
>> +
>> +		chconf |= is_read ? OMAP2_MCSPI_CHCONF_FFER :
>> +			OMAP2_MCSPI_CHCONF_FFET;
>
> Please avoid such extensive use of the ternery operator, it's not good
> for legibility.
>> +	} else {
>> +		mcspi->fifo_depth = 0;
>> +		chconf &= ~(is_read ? OMAP2_MCSPI_CHCONF_FFER :
>> +			OMAP2_MCSPI_CHCONF_FFET);
>> +	}
>> +
>> +	mcspi_write_chconf0(spi, chconf);
>
> We have a bunch of return statements further up the function in cases
> where the FIFO can't be used which means that if we're in FIFO mode then
> hit one of those we'll not disable FIFO mode as far as I can tell?
>

I will rework this in the next patch version.

[1]: http://www.ti.com/lit/ug/swpu235z/swpu235z.pdf

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
