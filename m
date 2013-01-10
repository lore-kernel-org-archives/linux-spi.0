From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mpc512x-psc: don't use obsolet cell-index
	property
Date: Fri, 11 Jan 2013 00:12:12 +0100
Message-ID: <20130111001212.3dd2c79a@crub>
References: <1356100981-18685-1-git-send-email-agust@denx.de>
	<CACxGe6sT_fsdcGN1OCRBVMXzAiDbbf=SnKp2F8eYL+F5Qoyu=g@mail.gmail.com>
	<20121221192914.77D523E03CE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121221192914.77D523E03CE@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Fri, 21 Dec 2012 19:29:14 +0000
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Fri, 21 Dec 2012 14:48:38 +0000, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> > On Fri, Dec 21, 2012 at 2:43 PM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> > > Use unique PSCx register base offset to obtain the
> > > SPI PSC number used for SPI bus id.
> > >
> > > Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> > 
> > Don't do this. If you really want to assign a specific bus number,
> > then use a property in /aliases. cell-index has been deprecated a very
> > long time ago now.
> 
> Ummm.. I really should read patches before I reply to them. I see you're
> removing cell-index, not adding it back in. It is fine.
> 
> Aliases would be a more generic solution though. Would this following
> change work for you? Try it out and let me know.

Sorry for delay. I've tried it now, it doesn't work. The mpc5121
psc spi driver also needs to get/enable psc clock of the used psc
controller. It uses psc bus number to generate psc clock name
string and to get and enable this clock, so I need to set
the bus number in the driver. I'll use of_alias_get_id() in the
the psc spi driver.


Thanks,

Anatolij

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
