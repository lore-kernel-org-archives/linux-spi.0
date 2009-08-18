From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Date: Wed, 19 Aug 2009 03:47:49 +0400
Message-ID: <20090818234749.GA30824@oksana.dev.rtsoft.ru>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220418.GD25090@oksana.dev.rtsoft.ru>
	<20090818222747.GB4354@suse.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Greg KH <gregkh@suse.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20090818222747.GB4354@suse.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 18, 2009 at 03:27:47PM -0700, Greg KH wrote:
> On Wed, Aug 19, 2009 at 02:04:18AM +0400, Anton Vorontsov wrote:
> > This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
> > driver so that now it doesn't define its own versions that cause build
> > breakage when the generic stubs are used.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> As you're just deleting code, I'll ack that :)
> 
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Hopefully you have tested building this thing...

Yep, thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
