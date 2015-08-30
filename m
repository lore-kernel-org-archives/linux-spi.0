From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/2] change PTR_ERR argument
Date: Sun, 30 Aug 2015 20:05:09 +0200
Message-ID: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: alsa-devel@alsa-project.org
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Apply PTR_ERR to the value that was recently assigned.

---

 var/julia/linuxcopy/drivers/spi/spi-ep93xx.c   |    3 ++-
 var/julia/linuxcopy/sound/soc/qcom/lpass-cpu.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
