From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH/RFC 2/2] mtd: m25p80: Call a platform power method in
	the	driver
Date: Sun, 28 Aug 2011 13:29:13 +0300
Message-ID: <4E5A1879.2000508@mm-sol.com>
References: <cover.1314278151.git.svarbanov@mm-sol.com>	<b7d4ea5c5ca058568f4d561914fa8becfa9324e1.1314278151.git.svarbanov@mm-sol.com>
	<20110828052215.GA7033@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, linux-mtd@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20110828052215.GA7033@sapphire.tkos.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi, Baruch

Thanks for the comments !

Baruch Siach wrote:
> Hi Stanimir,
> 
> On Thu, Aug 25, 2011 at 04:29:12PM +0300, Stanimir Varbanov wrote:
>> On some devices the flash chip could be powered off when m25p driver
>> is probed. To avoid erroneous detection the power of the chip must be
>> turn on, add a power function in m25p_probe to switch on the power by
>> platform data. The power will be turned off at the probe end.
> 
> [snip]
> 
>> +	/* power on device while probing */
>> +	m25p_power(data, 1);
> 
> [snip]
> 
>> +out:
>> +	m25p_power(data, 0);
> 
> Shouldn't you power off in m25p_remove() as well?
> 

IMO, no, because m25p_power(off) is called from m25p_put_device(). Then 
m25p_put_device() is called from mtdchar::mtd_close(). m25p_remove must
fail if user didn't close mtdchar /dev/mtdX device.

The motivation to use power on/off in m25p_probe is because the flash 
chip might be not powered when driver probe is called. The chip is powered
on on the probe begging and powered off after JEDEC probe pass.

> baruch
> 

regards,
Stan

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
