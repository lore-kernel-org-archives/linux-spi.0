From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH v2] spi: QUP based bus driver for Qualcomm MSM chipsets
Date: Mon, 23 Jan 2012 07:58:51 -0800
Message-ID: <20120123155851.GA25417@codeaurora.org>
References: <y>
 <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
 <20120123104220.GV1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Harini Jayaraman <harinij@codeaurora.org>,
	grant.likely@secretlab.ca, bryanh@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kheitke@codeaurora.org, spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120123104220.GV1068@n2100.arm.linux.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 23, 2012 at 10:42:20AM +0000, Russell King - ARM Linux wrote:
> Not specific to this patch, but I notice that you have in your headers:
> 
> In-Reply-To: <y>
> References: <y>
> 
> This is rather annoying, because it means that anyone else who has the
> same lines ends up having their messages attached to your messages as
> part of the same thread.
> 
> I think you need to read the documentation for git-send-email again -
> and check that you're using the arguments concerning message ids and
> threading correctly.

More specifically, when git-send-email promps for an email address or
a message id, realize it's not asking a yes or not question.  The
default it prints in brackets is what you get if you press enter.  If
you press 'y', the reply will be from 'y' as seen here.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
