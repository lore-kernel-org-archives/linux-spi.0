From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 04/12] spi: add ti-ssp spi master driver
Date: Wed, 17 Nov 2010 13:31:37 +0000
Message-ID: <20101117133136.GA19488@rakim.wolfsonmicro.main>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<4CE31F0E.7050103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>,
	"khilman@deeprootsystems.com" <khilman@deeprootsystems.com>,
	"linus.ml.walleij@gmail.com" <linus.ml.walleij@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
To: Cyril Chemparathy <cyril@ti.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4CE31F0E.7050103@ti.com>
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

On Tue, Nov 16, 2010 at 07:17:18PM -0500, Cyril Chemparathy wrote:

> The ability to wait on multiple devices may come handy.  In this

This is essential for any helpers, otherwise we can't cope easily with
mixes of GPIO and power or with regulators from multiple chips (like an
extra DCDC, for example).
