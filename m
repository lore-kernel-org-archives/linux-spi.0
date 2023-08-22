Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B60EE49A3
	for <linux-spi@archiver.kernel.org>; Wed, 23 Aug 2023 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjHWCzi (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjHWCzi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 22:55:38 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:55:35 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1041B9
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 19:55:35 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-6a-64e55cb879c1
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id AB.38.10987.8BC55E46; Wed, 23 Aug 2023 06:11:20 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=X0onG4OmH/EbxOAjXsAghiPn+EpAAh/vutyqWrvTURv5fVTk3r3CP0lZ2G4xqBG6J
          L7QXMbeLTFj+uxOYOZ9275UoYw7Zv0pQ19XsuLear+3zLRqcc2PbHnI881y0J9b3k
          Lqgu7dWW9sn1kX1ZN8/hVPCCv2+X5xU7IpCUXUVeI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=cKpfoOapeMLmrCbrkVS6WC9F6SMdFuwe7zujccOCjR4i6969IpvUNLKq6tcZJA+N1
          w3zJ9CquGpvJQzz6FIH2pWhxk9DR8pAPZ65299/F1q/5nt9HgIH6+JuuuQiT1lCrX
          1DV1X1Bporlj/Ae/2YiExiSmBBu5NyE1oquAMuRb8=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:08 +0500
Message-ID: <AB.38.10987.8BC55E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-spi@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:22 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW3dHzNMUg69H9SwaP95kd2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCRWHyri7WLkYtDSGAP
        k8T6rz1gDovAamaJ9lOnWSCch8wSh1ZMZ4Qoa2aU6D7xiBmkn1fAWuLClS1gs5gF9CRuTJ3C
        BhEXlDg58wkLRFxbYtnC10D1HEC2msTXrhKQsLCAmMSnacvYQWwRAVmJ+x9mM4LYbAL6Eiu+
        NoPZLAKqElNON4CNFxKQkth4ZT3bBEb+WUi2zUKybRaSbbMQti1gZFnFKFFcmZsIDLZkE73k
        /NzixJJivbzUEr2C7E2MwEA8XaMpt4Nx6aXEQ4wCHIxKPLw/1z1JEWJNLAPqOsQowcGsJMIr
        /f1hihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeW6FnyUIC6YklqdmpqQWpRTBZJg5OqQbGVfH2
        H0stLGUOHszy8dqfm1cTsejRia2SrsG/lu+4tUkuVzn/lWKyqLmOzsfXu9cq/5kTdVWxUuvI
        3vfrbM++Ev5q8nBi67mV8bX/VTdrnbV05Sz8mjzHceqX604XRS2YdTbc5l1x5VzlcbOX+vOO
        HJkce0onvd6u+KaSVtbqZrU77WUGBY9tlFiKMxINtZiLihMBtCfTRUACAAA=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

