From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: mc13xxx: add I2C support
Date: Thu, 19 Jan 2012 12:12:31 +0100
Message-ID: <87lip4kktc.fsf@lebrac.rtp-net.org>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sameo@linux.intel.com, mkl@pengutronix.de, linux-i2c@vger.kernel.org,
 u.kleine-koenig@pengutronix.de, spi-devel-general@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org
To: Marc Reilly <marc@cpdesign.com.au>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au> (Marc
 Reilly's message of "Thu, 19 Jan 2012 12:01:31 +1100")
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

Marc Reilly <marc@cpdesign.com.au> writes:

> Hi,

Hi,

>
> This series (based on 3.2) adds I2C support for the mc13xxx family PMICs.
> The patches are similar, but not identical to my previous patches for this [1], the
> main difference being the way the config items are done in patch 2.
>
> I don't have the hardware to retest on SPI hardware, I'd appreciate if someone could 
> double check it still works.
>
> I've also got a stack of patches for the mc13xxx to follow, but should get this in
> first.

I've never looked at regmap deeply but can't it be done with regmap or is it
just a bad idea ?

Arnaud
