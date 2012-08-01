From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Wed, 1 Aug 2012 11:48:36 +0800
Message-ID: <20120801034834.GA1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<20120731205300.GA25721@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Detlev,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Dong,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120731205300.GA25721-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 31, 2012 at 01:53:00PM -0700, Guenter Roeck wrote:
> > +	spi_master_put(host);
> > +	kfree(host);
> > +
> 
> Is the kfree() here and in the probe function really necessary ? 
> 
The following is how the kerneldoc of spi_alloc_master says.

 * The caller is responsible for assigning the bus number and initializing
 * the master's methods before calling spi_register_master(); and (after errors
 * adding the device) calling spi_master_put() and kfree() to prevent a memory
 * leak.

> Couple of reasons for asking: No other SPI master driver calls it in the remove
> function (unless I missed it), most drivers don't call it in the probe
> function error path, and if I call it in the remove function in a SPI master
> driver I am working on, and load/unload the module several times in a row, I get
> a nasty kernel crash.
> 
So sounds like either code or the kerneldoc needs patching?

Regards,
Shawn


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
