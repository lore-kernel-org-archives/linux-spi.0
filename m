From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Wed, 1 Jan 2014 21:13:56 +0200
Message-ID: <20140101191356.GB6589@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
 <20131226114258.GH8064@book.gsilab.sittig.org>
 <20131226115826.GY11794@sapphire.tkos.co.il>
 <20131226153346.GN8064@book.gsilab.sittig.org>
 <20140102002133.46eef5d3@feng-snb>
 <20140101173249.GS31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140101173249.GS31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark, Feng,

On Wed, Jan 01, 2014 at 05:32:49PM +0000, Mark Brown wrote:
> On Thu, Jan 02, 2014 at 12:21:33AM +0800, Feng Tang wrote:
> > But if you do see problem with this behavior, we can change it and
> > also notify the other spi controllers who use the same method. 
> 
> All the drivers should be being converted to use transfer_one() (and the
> forthcoming stuff extending that) which will handle delay_usecs for them
> anyway.

As I mentioned in the cover letter of this series, I have patches to convert 
this driver to the generic queue. If someone with access to hardware is 
willing to test, I'll post it. It is not clear yet whether I'll have access to 
hardware in the near future.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
