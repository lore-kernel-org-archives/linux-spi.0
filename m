From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH 1/2 v2] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Mon, 29 Sep 2014 12:53:20 +0300
Message-ID: <20140929095320.GE1786@lahna.fi.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-2-git-send-email-alvin.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hock Leong Kweh <hock.leong.kweh@intel.com>,
 Russell King <linux@arm.linux.org.uk>, Raymond Tan <raymond.tan@intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Boon Leong Ong <boon.leong.ong@intel.com>, Eric Miao <eric.y.miao@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
To: Weike Chen <alvin.chen@intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1412000548-9908-2-git-send-email-alvin.chen@intel.com>
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

On Mon, Sep 29, 2014 at 07:22:27AM -0700, Weike Chen wrote:
> Introduce helper functions to access the 'SSCR0' and 'SSCR1'.
> 
> Signed-off-by: Weike Chen <alvin.chen@intel.com>

Please fix the minor issues Andy pointed out and then you can have my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
