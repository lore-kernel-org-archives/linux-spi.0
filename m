From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: tegra: remove support of legacy
 DMA driver based access
Date: Fri, 14 Sep 2012 17:33:40 +0100
Message-ID: <20120914163340.GF4684@opensource.wolfsonmicro.com>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com>
 <1345126397-28864-6-git-send-email-ldewangan@nvidia.com>
 <50526DFE.5030709@wwwdotorg.org>
 <20120914155335.GB4684@opensource.wolfsonmicro.com>
 <505354A7.3090502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vinod.koul@linux.intel.com, linux@arm.linux.org.uk,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 grant.likely@secretlab.ca, linux-tegra@vger.kernel.org,
 Laxman Dewangan <ldewangan@nvidia.com>, olof@lixom.net,
 spi-devel-general@lists.sourceforge.net, lrg@ti.com
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <505354A7.3090502@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 14, 2012 at 10:00:39AM -0600, Stephen Warren wrote:

> But do note that I pinged 8 days ago for an ack, and received no
> objections, and you were well aware that the bug was fixed since you

I didn't read these mails enough to notice that they were asking for an
ack, they were followups to already discarded patches (the were
discarded due to the testing problems).  One of the things I do to deal
with mail overload is to drop followups to patches that I don't remember
reviewing (as in this case where the negative test reports arrived
before I saw the patches) or where I remember I was already happy.

> applied the fix to the Tegra ASoC PCM driver yourself, and we had
> discussed this being a dependency for the dmaengine patches, and you'd
> told me to just base the Tegra branch on top of your tree until a signed
> tag was available for me to base upon.

I knew it was a dependency, I didn't know that there were no further
changes required to the series - your note when you posted the patch
didn't mention anything.
