From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: register spi child
 devices of spi node
Date: Tue, 27 Jul 2010 15:52:53 +0800
Message-ID: <20100727155253.765b7c3d@feng-i7>
References: <20100727153358.60881da6@feng-i7>
	<200077.42951.qm@web180308.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	"alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200077.42951.qm-g47maUHHHF8P4eY3Ra60wvu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 27 Jul 2010 15:27:50 +0800
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> 
> 
> --- On Tue, 7/27/10, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > What I want to say is the matching mechanism between spi
> > board info
> > and spi master, currently they use bus number to match, but
> > there is
> > a ordering limit now. For general device/driver matching in
> > linux
> > device model, there is no such limit. Is it
> > possible to remove the order limit?
> 
> 
> I have no idea what you mean.  Are you proposing
> to change how SPI busses are identified?  Lots of
> busses are numbered, SPI isn't unique; a device on
> PCI bus #2 is different from one on bus #1, etc.
> 
> What do you mean by "order limit" ???? 
> 

In current spi core, spi_register_info() has to be
called before the spi controller driver call spi_register_master(),
then these board info will be matched and used to create a new
spi device.

But if spi_register_info() are called after its related spi master
is registered, then these info will be ignored and never get to
create a new spi device.

This is the "order limit" I want to describe :)

Thanks,
Feng

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
