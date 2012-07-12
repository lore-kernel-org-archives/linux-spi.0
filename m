From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI: bcm63xx_dev_spi.h
Date: Thu, 12 Jul 2012 23:26:42 +0200
Message-ID: <CAOiHx=nHf+rRGsw_pvSwxKn5VE9QYvCvy_p6j1ETf9HSHBgUNQ@mail.gmail.com>
References: <1342126544.22584.36.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1342126544.22584.36.camel-uMdlDhfIn7prKue/0VVhAg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12 July 2012 22:55, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> 0) Commit b42dfed83d95a3c9e9cbd708f1993a7474abb79a ("spi: add Broadcom
> BCM63xx SPI controller driver") added drivers/spi/spi-bcm63xx.c to the
> mainline tree. That file includes bcm63xx_dev_spi.h.
>
> 1) bcm63xx_dev_spi.h is not part of the current tree, and, as far as I
> can tell, has actually never been part of the tree. So it seems that
> this driver could never be built using the mainline tree since it got
> added (in v3.4).
>
> 2) What's the current status of this header?

It currently sits in Ralf Baechle's queue and waits for the merge window:

http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commit;h=435f920f35e90b4681e68002d2e2f6724b0c21b7


Jonas

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
