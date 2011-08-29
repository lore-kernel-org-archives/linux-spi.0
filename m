From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: Fix builderror in spi-pl022.c
Date: Mon, 29 Aug 2011 10:41:39 +0200
Message-ID: <CACRpkdavhLpsfFwHy3jnHO3o9EC+e6=dt1joMGQD_e3O=HTT-A@mail.gmail.com>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, spi-devel-general@lists.sourceforge.net,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
To: Peter Huewe <peterhuewe@gmx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
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

On Sun, Aug 28, 2011 at 9:26 PM, Peter Huewe <peterhuewe@gmx.de> wrote:

> This patch fixes a build error, introduced by commit (67fc8b9f, "PM: add
> runtime PM support to core Primecell driver") which unfortunately was a little
> bit incomplete and did contain a typo (11 instead of 22).
> I'm not sure how this patch could have been tested back then, if it
> doesn't even compile ;)
>
> The build failure was:
> drivers/spi/spi-pl022.c:2292: error: 'adev' undeclared (first use in
> this function)
> drivers/spi/spi-pl022.c:2344: error: 'pl022_suspend' undeclared here
> (not in a function)
>
> The build failure appears e.g. for the u8500 and realview defconfig.
>
> LinuxVersion: linux next-20110826
>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
