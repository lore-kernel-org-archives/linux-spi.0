Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D06EB64DA
	for <linux-spi@archiver.kernel.org>; Fri, 14 Jul 2023 03:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjGNDjc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 13 Jul 2023 23:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjGNDjb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jul 2023 23:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1A426B5;
        Thu, 13 Jul 2023 20:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA4A61BE3;
        Fri, 14 Jul 2023 03:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4896BC433C7;
        Fri, 14 Jul 2023 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689305969;
        bh=p0Ke1MkfcHMLuNdkmv8ZeOB63I7ctN3WX/1LXBJwBAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yvbv7a1i7s46OWI4k+ChWwV2wPVjwDOviMyyz+EtVLfYTFdu3JJerTcOz3DWPLhWm
         SmTvVxY5zUBJl9Wm8TW3XpQX/dypqBS0d7nTtuORn3ImYSEIYgs1fWWRhN3IPaHYBd
         Cx0i4oKtkxRA2VWNQ2j6wmbYkXC26Dv9SA1JPiqGqCeNg6Cw4/kbIN0+XvMspXkXBm
         sMdKCqlFS9v8RCn50KRwMfR/1wGnCLFfhQifCNOG4XPUlRBrJF5OVStTqFEqbfS9Nc
         lIbpjBsaXNukG+uj/ZGe+fyPmed8Pgm6LkL6DQwi06VSLK5ptxUYlZYRYg27Vn5GkT
         kHFOm+TpVKS/A==
Date:   Thu, 13 Jul 2023 20:42:58 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Praveen Talari <quic_ptalari@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_vnivarth@quicinc.com,
        quic_arandive@quicinc.com,
        Praveen Talari <ptalari@qti.qualcomm.com>
Subject: Re: [PATCH v6 1/2] soc: qcom: geni-se: Add SPI Device mode support
 for GENI based QuPv3
Message-ID: <rn42gbse2ji6h6w4vfwzp3odihboz6sgxq3kssuxcyeu63itre@hy63ndshgrfz>
References: <20230713115145.16770-1-quic_ptalari@quicinc.com>
 <20230713115145.16770-2-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713115145.16770-2-quic_ptalari@quicinc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 13, 2023 at 05:21:44PM +0530, Praveen Talari wrote:
> From: Praveen Talari <ptalari@qti.qualcomm.com>
> 
> Add device mode supported registers and masks.
> 
> Signed-off-by: Praveen Talari <ptalari@qti.qualcomm.com>

Shouldn't this be quic_ptalari@quicinc.com

Regards,
Bjorn
