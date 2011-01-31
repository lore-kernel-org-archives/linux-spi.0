From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v8 01/11] mfd: add driver for sequencer serial port
Date: Mon, 31 Jan 2011 01:40:02 +0100
Message-ID: <20110131004001.GF2565@sortiz-mobl>
References: <1295378505-15221-1-git-send-email-cyril@ti.com>
 <1295378505-15221-2-git-send-email-cyril@ti.com>
 <87tyh4u6uo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>,
	davinci-linux-open-source@linux.davincidsp.com,
	spi-devel-general@lists.sourceforge.net, rpurdie@rpsys.net,
	dbrownell@users.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, Cyril Chemparathy <cyril@ti.com>
To: Kevin Hilman <khilman@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87tyh4u6uo.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Kevin,

On Wed, Jan 19, 2011 at 09:43:43AM -0800, Kevin Hilman wrote:
> Samuel,
> 
> Cyril Chemparathy <cyril@ti.com> writes:
> 
> > TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> > device.  It has a built-in programmable execution engine that can be programmed
> > to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> >
> > This patch adds a driver for this controller device.  The driver does not
> > expose a user-land interface.  Protocol drivers built on top of this layer are
> > expected to remain in-kernel.
> >
> > Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> 
> Any comments on this driver?
The driver looks fine.


> With your ack, I'll be happy to merge this via the davinci tree with the
> rest of the series.
Please go ahead and add my Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
