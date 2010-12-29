From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/9] spi/pxa2xx: register driver properly
Date: Wed, 29 Dec 2010 22:26:35 +0100
Message-ID: <20101229212635.GA31347@www.tglx.de>
References: <20101229081120.GN8172@angua.secretlab.ca>
	<349566.41372.qm@web180301.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, linux@arm.linux.org.uk,
	Grant Likely <grant.likely@secretlab.ca>,
	sodaville@linutronix.de, spi-devel-general@lists.sourceforge.net,
	Dirk Brandewie <dirk.brandewie@gmail.com>, eric.y.miao@gmail.com,
	linux-arm-kernel@lists.infradead.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <349566.41372.qm@web180301.mail.gq1.yahoo.com>
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

* David Brownell | 2010-12-29 09:00:36 [-0800]:

>I detect an effort to change the classic model for board initialization in Linux:  first set up
>and register all system/platform devices on each
>board then do the same for their drivers.  ("hardware first" ... "software second".

What are you suggesting? platform_driver_probe() does not work with
hotpluged devices.
I don't see a reason why it should be available to drivers. It is
unlikely that platform devices are hotlpluged but not impossible.

>- Dave

Sebastian
