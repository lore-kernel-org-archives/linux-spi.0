From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
 non-QE/CPM builds
Date: Tue, 18 Aug 2009 15:27:47 -0700
Message-ID: <20090818222747.GB4354@suse.de>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
 <20090818220418.GD25090@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752059AbZHRWci@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090818220418.GD25090@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 19, 2009 at 02:04:18AM +0400, Anton Vorontsov wrote:
> This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
> driver so that now it doesn't define its own versions that cause build
> breakage when the generic stubs are used.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

As you're just deleting code, I'll ack that :)

	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Hopefully you have tested building this thing...

thanks,

greg k-h
