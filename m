From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [RFC] spi: Switch call order of spi master setup and spi_set_cs
Date: Tue, 13 Oct 2015 09:03:21 -0500
Message-ID: <561D0F29.5090001@ti.com>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
 <20151013121047.GD14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<nsekhar@ti.com>, <ssantosh@kernel.org>, <iivanov@mm-sol.com>,
	<m-karicheri2@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151013121047.GD14956@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/13/2015 07:10 AM, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 04:01:10PM -0500, Franklin S Cooper Jr wrote:
>> Keystone 2 devices currently fail to boot in linux-next after the
>> below commit was applied:
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.
Sorry about that. Will do next time.
