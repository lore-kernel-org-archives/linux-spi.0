From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: refactor spi-coldfire-qspi to use SPI queue
	framework.
Date: Sat, 19 May 2012 22:57:29 -0600
Message-ID: <20120520045729.63B9A3E03B8@localhost>
References: <201205100926.55444.sfking@fdwdc.com>
	<4FACB1A9.3060800@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
To: Greg Ungerer <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4FACB1A9.3060800-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 11 May 2012 16:28:57 +1000, Greg Ungerer <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org> wrote:
> On 11/05/12 02:26, Steven King wrote:
> > Use the new SPI queue framework; remove use of workqueue, replace
> > mcfqspi_transfer with mcfqspi_transfer_one_message, add
> > mcfqspi_prepare_transfer_hw and mcfqspi_unprepare_transfer_hw, update power
> > management routines.
> >
> > Signed-off-by: Steven King<sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
> 
> I can't add much value reviewing this one, style wise it looks good.

I'll take that as an ack.

> 
> Grant: if you don't want to take this through one of your trees
> I can add it to the m68knommu git tree.

Merged, thanks.

g.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
