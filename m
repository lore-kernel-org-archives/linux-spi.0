From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 21:10:42 +0800
Message-ID: <8316c6e9-9000-bd1e-aa96-3db069e61824@huawei.com>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
 <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20190410123558.GQ6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
To: Mark Brown <broonie@kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410123558.GQ6106@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2019/4/10 20:35, Mark Brown wrote:
> On Wed, Apr 10, 2019 at 12:30:37PM +0000, Naga Sureshkumar Relli wrote:
> 
>>> Yeah, I'm surprised that builds...
> 
>> Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.
> 
> I also see that I'd queued an earlier version for application.  I've
> lost track of whatever issues there were with that, sorry - could one of
> you please post an incremental patch for them?  IIRC they were nice to
> haves and the patch that was applied fixes the correctness issue.

Ok, there just make the stub helper to  static inline

I can post a new patch based my initial patch.

> 
