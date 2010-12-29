From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9] spi/pxa2xx: register driver properly
Date: Wed, 29 Dec 2010 09:00:36 -0800 (PST)
Message-ID: <349566.41372.qm@web180301.mail.gq1.yahoo.com>
References: <20101229081120.GN8172@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, linux@arm.linux.org.uk,
	eric.y.miao@gmail.com, sodaville@linutronix.de,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101229081120.GN8172@angua.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



> Date: Wednesday, December 29, 2010, 12:11 AM
> On Thu, Dec 02, 2010 at 06:47:29PM
> +0100, Sebastian Andrzej Siewior wrote:
> > use platform_driver_register instead of
> platform_driver_probe. The
> > latter only checks available devices at the time of
> calling. So if a
> > device gets inserter at a later point in time then the
> driver will never
> > play with it.


I detect an effort to change the classic model for board initialization in Linux:  first set up
and register all system/platform devices on each
board then do the same for their drivers.  ("hardware first" ... "software second".

(Without such a change, there's no need for
 patches like this (of which I've recently
seen a few).

I've not seen discussion about the desirability
of such a change.

- Dave


Has this change
