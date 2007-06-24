From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver
Date: Mon, 25 Jun 2007 01:15:33 +0900 (JST)
Message-ID: <20070625.011533.108738339.anemo@mba.ocn.ne.jp>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org,
	sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706221103.19761.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 22 Jun 2007 11:03:18 -0700, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > +	if (res->start >= TXX9_DIRECTMAP_BASE)
> > +		c->membase = (void __iomem *)(unsigned long)(int)res->start;
> > +	else {
> > +		c->membase = ioremap(res->start, res->end - res->start + 1);
> > +		c->mapped = 1;
> > +	}
> 
> That looks plain wrong.  Maybe it reflects a platform-level bug,
> but ioremap(res->start) should Just Work even when it performs
> an identity mapping on a given system.  Remove this ugly code.
> Always map.

Ralf, (as I said some time ago) TX39XX and TX49XX have "reserved"
segment in CKSEG3 area.  0xff000000-0xff3fffff on TX49XX and
0xff000000-0xfffeffff on TX39XX are reserved (unmapped, uncached).
Controllers on these SoCs are placed in this segment.

If ioremap()/iounmap() could handle these special case, I can remove
this hack in this driver.

Is something like this acceptable?

include/asm-mips/io.h:
static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
	unsigned long flags)
{
	void __iomem *addr = plat_ioremap(offset, size, flags);
	if (addr)
		return addr;
	...
}

static inline void iounmap(const volatile void __iomem *addr)
{
	if (plat_iounmap(addr))
		returnl
	...
}

include/asm-mips/mach-generic/ioremap.h:
static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
	unsigned long flags)
{
	return NULL;
}

static inline int plat_iounmap(const volatile void __iomem *addr)
{
	return 0;
}

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
