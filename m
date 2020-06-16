Return-Path: <SRS0=xt6i=75=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FDC433E0
	for <linux-spi@archiver.kernel.org>; Tue, 16 Jun 2020 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31FE20739
	for <linux-spi@archiver.kernel.org>; Tue, 16 Jun 2020 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592338816;
	bh=VnbSghNFJwHgHjauf4cRYoD6DgbA3nhckYXVYPI6iGM=;
	h=Subject:From:Date:To:List-ID:From;
	b=M+V0C1EZuCldmhPwcgRvaYgX0IUVrTbT3GBY8mDIZAR6XwTfLhhRzM37o8crFkQCK
	 YNTbwhH41jzfiVyysBnkP9E8uvTJHtvnKytM4ryP2rBJuAV9J7B7As3VYSKSsmG0IT
	 mnZypAbf19hK/kagGVyL0McVHnEFezrvneeKklCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFPUUQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbgFPUUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 16:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592338816;
        bh=VnbSghNFJwHgHjauf4cRYoD6DgbA3nhckYXVYPI6iGM=;
        h=Subject:From:Date:To:From;
        b=0rX7MpfVK/WngW6h665igm5kgS06dIhoFVY+QjHzujoYlhX1QraAujZDm5O9UXE0O
         BLV/gkYGqYled4lLnewxM+7PjNALAyd+xzt6csAd1sZrYONNwwiE2FBfhzcBPhtgQi
         eF+ZAm6yKbewDY77EMXq6IOLyTt0cR+LL8KH14y4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159233881604.1918.10913595142399518849.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 20:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add Renesas RPC-IF support (2020-06-16T20:00:20)
  Superseding: [v3] Add Renesas RPC-IF support (2020-06-13T18:37:47):
    [v4,1/2] dt-bindings: memory: document Renesas RPC-IF bindings
    [v4,2/2] memory: add Renesas RPC-IF driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
