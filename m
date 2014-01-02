From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHNwaTogY2xwczcxMXg6IERyaXZlciByZWZhY3Rv?=
 =?UTF-8?B?cg==?=
Date: Thu, 02 Jan 2014 22:20:34 +0400
Message-ID: <1388686834.668518989@f215.i.mail.ru>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <20140101150737.GR31886@sirena.org.uk>
 <201401021846.23488.arnd@arndb.de>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: =?UTF-8?B?QXJuZCBCZXJnbWFubg==?= <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201401021846.23488.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> On Wednesday 01 January 2014, Mark Brown wrote:
> > > As an alternative, I can create patch to remove current driver,
> > > then re-adding new one.  Will be more convenient to watch. Is it better? 
> > 
> > No, that's really not good.  It's very rare that we just completely
> > rewrite a driver especially not one that's been around for a while -
> > there needs to be a really good reason for it.  This is a key part of
> > how the development process works, incremental improvements and code
> > review.  Doing this both helps improve quality control on changes and
> > allows collaboration.
> 
> I definitely agree with what you say, but please note that Alexander is
> the only person who ever sends clps711x patches, so there is not much
> hope of collaboration. I also suspect he's the only one who would
> suffer from accidental breakage, especially since the existing driver
> is not used anywhere upstream (no instance of platform data, and no
> DT support).

Thanks for protection Arnd :) 
Indeed, all as you say, of course it does not mean that I got VIP status and
can make any changes to the kernel tree,
make me comments - I'm learning this.

---
