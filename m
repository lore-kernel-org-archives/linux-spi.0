From: Illia Smyrnov <x0194613-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-omap2-mcspi.c: Add dts for slave device
	configuration.
Date: Thu, 6 Jun 2013 13:08:46 +0300
Message-ID: <51B05FAE.60508@ti.com>
References: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
	<1370432398-7796-2-git-send-email-illia.smyrnov@ti.com>
	<20130605115734.GY31367@sirena.org.uk>
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
In-Reply-To: <20130605115734.GY31367-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/05/2013 02:57 PM, Mark Brown wrote:
> On Wed, Jun 05, 2013 at 02:39:57PM +0300, Illia Smyrnov wrote:
>
>> +SPI Controller specific data in SPI slave nodes:
>> +- The spi slave nodes can provide the following information which is used
>> +  by the spi controller:
>> +  - ti,spi-turbo-mode: Set turbo mode for this device.
>> +
>
> What is turb mode and

According to OMAP TRM [1] MCSPI turbo mode improves the throughput of 
the SPI interface when a single channel is enabled by allowing transfers 
until the shift register and the MCSPI_RXx register are full.

I tested turbo mode using KS8851 SPI Ethernet controller on Blaze with 
OMAP4460 and nuttcp tool with -r for RX throughput measuring. Enabling 
turbo mode was increased throughput form 7.5538 Mbps to 8.3848 Mbps

> why would we not want to just enable it all the
> time?

Turbo mode gives the expected results not for all cases. There are some 
limitations:
- works only if a single channel is enabled (no effect when several 
channels are enable);
- improves the throughput on RX direction only;
- effective only when a transfer exceeds two words. For single SPI
word transfers OMAP TRM [1] recommends deactivate turbo mode.

So it is useful to have the property in DT, that allow us to switch 
turbo mode off/on for certain slave.

> Based on this documentation it's not really possible to tell...
>
I will add turbo mode description to documentation in the next patch version

[1]: http://www.ti.com/lit/ug/swpu235z/swpu235z.pdf

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
