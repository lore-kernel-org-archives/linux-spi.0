From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] spi_mpc83xx: test below 0 on unsigned irq in mpc83xx_spi_probe()
Date: Wed, 30 Apr 2008 15:12:10 -0700
Message-ID: <200804301512.11317.david-b@pacbell.net>
References: <480F99D5.7070300@tiscali.nl> <7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Roel Kluin <12o3l@tiscali.nl>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765774AbYD3WMb@vger.kernel.org>
In-Reply-To: <7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 23 April 2008, Kumar Gala wrote:
> 
> On Apr 23, 2008, at 3:19 PM, Roel Kluin wrote:
> > mpc83xx_spi->irq is unsigned, so the test fails
> >
> > Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Any reason to not just make mpc83xx_spi->irq be "int",
following normal practice everywhere?  If not, I'll
roll that into the patch from Joakim Tjernlund...

- Dave
