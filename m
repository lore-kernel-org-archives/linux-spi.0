From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
Date: Wed, 08 Oct 2014 02:03:18 +0100
Message-ID: <54348D56.20708@nexus-software.ie>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com> <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
Reply-To: pure.logic@nexus-software.ie
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@intel.com>,
	Hock Leong Kweh <hock.leong.kweh@intel.com>,
	Boon Leong Ong <boon.leong.ong@intel.com>,
	Raymond Tan <raymond.tan@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Weike Chen <alvin.chen@intel.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 29/09/14 15:22, Weike Chen wrote:
> +		.num_chipselect = 4,

How is this right ?

There's only one physical chip-select line per SPI master...

It's a 1:1 mapping.

Best,
Bryan
