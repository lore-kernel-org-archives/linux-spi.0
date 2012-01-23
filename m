From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] spi: QUP based bus driver for Qualcomm MSM chipsets
Date: Mon, 23 Jan 2012 10:42:20 +0000
Message-ID: <20120123104220.GV1068@n2100.arm.linux.org.uk>
References: <y> <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: grant.likely@secretlab.ca, bryanh@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kheitke@codeaurora.org, spi-devel-general@lists.sourceforge.net,
	davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org
To: Harini Jayaraman <harinij@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Not specific to this patch, but I notice that you have in your headers:

In-Reply-To: <y>
References: <y>

This is rather annoying, because it means that anyone else who has the
same lines ends up having their messages attached to your messages as
part of the same thread.

I think you need to read the documentation for git-send-email again -
and check that you're using the arguments concerning message ids and
threading correctly.

Thanks.
