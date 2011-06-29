From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Date: Wed, 29 Jun 2011 19:00:53 +0200
Message-ID: <87ipro4loa.fsf@macbook.be.48ers.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
	<20110628212443.GI21138@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
To: Ben Dooks <ben@trinity.fluff.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110628212443.GI21138@trinity.fluff.org> (Ben Dooks's message
	of "Tue, 28 Jun 2011 22:24:43 +0100")
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

>>>>> "Ben" == Ben Dooks <ben@trinity.fluff.org> writes:

 >> The spi-s3c24xx-gpio driver is functionally equivalent to the spi-gpio
 >> driver (but precedes it). The driver has seen very little development 
 >> since it got added back in 2006, and there's only 2 in-tree users of it.
 >> 
 >> This patch series moves the remaining users to the spi-gpio driver and
 >> then finally removes the driver.
 >> 
 >> Compile tested only as I don't have access to the hardware.

 Ben> I've not really got much in the way of access either, however the
 Ben> series looks sane to me.

 Ben> Acked-by: Ben Dooks <ben-linux@fluff.org>

Great, will you handle the series or should it go through the spi tree?

-- 
Bye, Peter Korsgaard
